Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277350AbRJELQs>; Fri, 5 Oct 2001 07:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277352AbRJELQi>; Fri, 5 Oct 2001 07:16:38 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:14345 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S277350AbRJELQW>; Fri, 5 Oct 2001 07:16:22 -0400
Message-ID: <3BBD8FE0.CEF3E283@namesys.com>
Date: Fri, 05 Oct 2001 14:48:00 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Clemens Schwaighofer <cs@pixelwings.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?  (fwd)
In-Reply-To: <E15oqKN-00058k-00@calista.inka.de> <746710000.1002192137@gullevek.piwi.intern>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer wrote:
> 
> Hello Bernd Eckenfels
> 
> --On Wednesday, October 03, 2001 08:01:03 PM +0200 you wrote:
> 
> > In article <706340000.1002116485@gullevek.piwi.intern> you wrote:
> >> but to the point of that thread. we had reiser FS on a production server
> >> (Fileserver for NFS, Samba & Appletalk) and we nothing but troubles. It
> >> was an 2.2.16 kernel and i dunno witch reiserfs we used. But from this
> >> point forward I dun think I will use it again soon on a production
> >> server.
> >
> > Do you had NFS Problems or do you had filesystem problems?
> 
> Filesystem Problems. Massive problems. It went so far, that the system was
> so unstable, that I had to reboot it almost everyday.
> 
> > Because NFS interaction with Journaled Filesystems is/was an issue with
> > those recent kernels, as far as i understand.
> 
> I might have came from NFS, AppleTalk, Samba, who knows. But I couldn't go
> into detail testing, and I needed to fix it up. I might try ext3 one, cause
> I work with it at home and I am quite happy with it, but it's just a home
> system not a production enviroment ...
> 
> --
> "Freiheit ist immer auch die Freiheit des Andersdenkenden"
> Rosa Luxemburg, 1871 - 1919
> mfg, Clemens Schwaighofer              PIXELWINGS Medien AG
> Kandlgasse 15/5, A-1070 Wien           T: [+43 1] 524 58 50
> JETZT NEU! MIT FEWA GEWASCHEN --> http://www.pixelwings.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


You would find it much more stable today, and I expect that it was NFS plus
reiserfs interaction that was the bug back then for you.

Hans
