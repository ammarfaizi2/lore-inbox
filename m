Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268233AbTB1XCF>; Fri, 28 Feb 2003 18:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268239AbTB1XCF>; Fri, 28 Feb 2003 18:02:05 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:63463 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S268233AbTB1XCE>; Fri, 28 Feb 2003 18:02:04 -0500
Message-ID: <20030228231220.19048.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: akpm@digeo.com, "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Date: Sat, 01 Mar 2003 00:12:20 +0100
Subject: Re: anticipatory scheduling questions
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: Andrew Morton <akpm@digeo.com> 
Date: Fri, 28 Feb 2003 11:14:18 -0800 
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> 
Subject: Re: anticipatory scheduling questions 
 
> "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote: 
> > I have done so: Evolution is a complex application with many interdependencies and is  
> > not very prone to launch diagnostic messages to the console. Anyways, I haven't seen  
> > any diagnostic message in the console. I still think there is something in the AS I/O scheduler  
> > that is not working at full read throughput. Of course I'm no expert.  
>  
> It certainly does appear that way.  But you observed the same runtime 
> with the deadline scheduler.  Or was that a typo? 
>  
> > > 2.4.20-2.54 -> 9s   
> > > 2.5.63-mm1 w/Deadline -> 34s   
> > > 2.5.63-mm1 w/AS -> 33s  
 
It wasn't a typo... In fact, both deadline and AS give roughly the same timings (one second up or down). But I 
still don't understand why 2.5 is performing so much worse than 2.4. Could a "vmstat" or "iostat" dump be 
interesting? 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
