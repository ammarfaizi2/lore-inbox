Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAPVwj>; Tue, 16 Jan 2001 16:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAPVw2>; Tue, 16 Jan 2001 16:52:28 -0500
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:35819 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129584AbRAPVwI>; Tue, 16 Jan 2001 16:52:08 -0500
Message-ID: <3A64C233.71E4E805@wanadoo.fr>
Date: Tue, 16 Jan 2001 22:50:43 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.0-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Fremlin <vii@altern.org>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-x features ?
In-Reply-To: <200101151959.f0FJxDB248265@saturn.cs.uml.edu> <m2wvbvod05.fsf@boreas.yi.org.>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin wrote:
> 
>  "Albert D. Cahalan" <acahalan@cs.uml.edu> writes:
> 
> > > 1) top (procps-2.0.7) gives me the messages :
> > > 'bad data in /proc/uptime'
> > > 'bad data in /proc/loadavg'
> > > cat /proc/uptime
> > > 1435.30 904.74
> > > cat /proc/loadavg
> > > 0.01 0.21 0.29 1/17 19444
> > > What is wrong ?
> 
> You probably have locale settings where the decimal point is a comma
> so scanf on /proc/loadavg etc. doesn't work. The following patch
> (submitted to RedHat ages ago) fixes that for me.

That's it. i persist in setting LANG=fr.

Thank you for the tip.

------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
