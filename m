Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132948AbRAPWUh>; Tue, 16 Jan 2001 17:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132957AbRAPWU1>; Tue, 16 Jan 2001 17:20:27 -0500
Received: from smtp-rt-10.wanadoo.fr ([193.252.19.59]:46542 "EHLO
	camelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S132948AbRAPWUT>; Tue, 16 Jan 2001 17:20:19 -0500
Message-ID: <3A64C8D1.4C0C0456@wanadoo.fr>
Date: Tue, 16 Jan 2001 23:18:57 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.0-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-x features ?
In-Reply-To: <200101151959.f0FJxDB248265@saturn.cs.uml.edu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> Pierre Rousselet writes:
> 
> > 1) top (procps-2.0.7) gives me the messages :
> > 'bad data in /proc/uptime'
> > 'bad data in /proc/loadavg'
> > cat /proc/uptime
> > 1435.30 904.74
> > cat /proc/loadavg
> > 0.01 0.21 0.29 1/17 19444
> > What is wrong ?
> 
> Which 2.4.0-x kernel, and how was procps compiled?
> (the broken gcc again perhaps?)
> 
> You might as well get procps-010114.tar.gz (new just yesterday!) and
> compile it yourself. The top command seems to tolerate Red Hat's
> fixed gcc, which you should get if you are using Red Hat 7.

I did that. Compilation OK with gcc-2.95.2 top still doesn't work (
top > /dev/null tells you 'bad data in ...' just before the screen
blanks).
logout after commenting LC_ALL=fr and LANG=fr in /etc/profile 
login again : top works. 

It is a question of '.' and ','


------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
