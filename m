Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbTDDNtd (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 08:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTDDNdf (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 08:33:35 -0500
Received: from imsp073.netvigator.com ([218.102.23.130]:3803 "EHLO
	imsp073.netvigator.com") by vger.kernel.org with ESMTP
	id S263623AbTDDNc1 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 08:32:27 -0500
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: [Swsusp] internal compiler error - gcc3.2 confirmed
Date: Fri, 4 Apr 2003 21:42:16 +0800
User-Agent: KMail/1.5.1
MIME-Version: 1.0
X-OS: GNU/Linux 2.4.21-pre5
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4uYj+DWUv6Ts+XY"
Message-Id: <200304042142.16795.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_4uYj+DWUv6Ts+XY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_4uYj+DWUv6Ts+XY
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 8bit
Content-Description: Robert Woerle Paceblade/Support <robert@paceblade.com>: Re: [Swsusp] internal compiler error

Received: from mail.fornax.hu [212.92.11.1] by ns3.dragon188.com.hk with ESMTP
  (SMTPD32-6.06) id A73210A0214; Fri, 04 Apr 2003 21:22:58 +0800
Message-ID: <3E8D8239.8030901@paceblade.com>
From: Robert Woerle Paceblade/Support <robert@paceblade.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030312
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: swsusp@lister.fornax.hu
Subject: Re: [Swsusp] internal compiler error
References: <3E8D7C65.5050505@paceblade.com>
In-Reply-To: <3E8D7C65.5050505@paceblade.com>
Content-Type: text/plain;
  charset=ISO-8859-1;
  format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *191QoL-0006Dt-00*xNoybck8wSY* (Fornax Co.)
Sender: swsusp-admin@lister.fornax.hu
Errors-To: swsusp-admin@lister.fornax.hu
X-BeenThere: swsusp@lister.fornax.hu
X-Mailman-Version: 2.0.11
Precedence: bulk
Reply-To: swsusp@lister.fornax.hu
List-Help: <mailto:swsusp-request@lister.fornax.hu?subject=help>
List-Post: <mailto:swsusp@lister.fornax.hu>
List-Subscribe: <http://lister.fornax.hu/mailman/listinfo/swsusp>,
	<mailto:swsusp-request@lister.fornax.hu?subject=subscribe>
List-Id: <swsusp.lister.fornax.hu>
List-Unsubscribe: <http://lister.fornax.hu/mailman/listinfo/swsusp>,
	<mailto:swsusp-request@lister.fornax.hu?subject=unsubscribe>
List-Archive: <http://lister.fornax.hu/pipermail/swsusp/>
Date: Fri, 04 Apr 2003 15:01:45 +0200
X-RCPT-TO: <mflt1@micrologica.com.hk>
X-UIDL: 326478183
Status: RO
X-Status: O
X-KMail-EncryptionState: N
X-KMail-SignatureState: N

i found that suse 8.2
uses gcc 3.3 (prerelease )

which doesnt sound too stable to me ...
i also have problems with ide-cd to compile .. and i get huge warninigs 
like

cdrom_buffer_sectors':
ide-cd.c:816: warning: comparison between signed and unsigned
ide-cd.c:816: warning: signed and unsigned type in conditional expression


in almost every module .....

Can somebody help installing a gcc 3.1 or even 2.95 parallel to the one 
i have here ???
i remmeber there was a way where i only needed to change some EXPORTS 
when i wanted to cchoose the gcc !!!

Rob

Robert Woerle Paceblade/Support schrieb:

> now i get this when i try to compile 2.4.20 with any swsusp patch !! ( 
> tried , beta19 and beta19-14 and beta19-16)
>
> the thing i changed is that i now use Suse 8.2 and before i had suse 
> 8.1 and everything was fine .
>
> i dont know if there is a gcc differenc between those 2 but it looks 
> like !!
>
> Cheers Rob
>
>
>
> cc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 
> -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0   
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=sched  
> -fno-omit-frame-pointer -c -o sched.o sched.c
> cc1: warning: -malign-loops is obsolete, use -falign-loops
> cc1: warning: -malign-jumps is obsolete, use -falign-jumps
> cc1: warning: -malign-functions is obsolete, use -falign-functions
> sched.c: In function `schedule':
> sched.c:611: warning: comparison between signed and unsigned
> sched.c:640: warning: comparison between signed and unsigned
> sched.c:709: internal compiler error: in merge_assigned_reloads, at 
> reload1.c:6133
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
>

-- 
_____________________________________
*Robert Woerle
**Technical Support | Linux
PaceBlade Technology Europe SA*
phone: 	+49 89 552 99935
fax: 	+49 89 552 99910
mobile: 	+49 179 474 45 27
email: 	robert@paceblade.com <mailto:robert@paceblade.com>
web: 	http://www.paceblade.com
_____________________________________






_______________________________________________
swsusp mailing list
swsusp@lister.fornax.hu
http://lister.fornax.hu/mailman/listinfo/swsusp


--Boundary-00=_4uYj+DWUv6Ts+XY--

