Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274611AbRIYKoj>; Tue, 25 Sep 2001 06:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274614AbRIYKo3>; Tue, 25 Sep 2001 06:44:29 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:25100 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S274611AbRIYKoP>; Tue, 25 Sep 2001 06:44:15 -0400
Date: Tue, 25 Sep 2001 12:44:40 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010925124440.B1390@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <20010925044949.JNOU8313.femail42.sdc1.sfba.home.com@there> <Pine.LNX.4.30.0109251335520.18440-100000@gamma.student.ljbc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0109251335520.18440-100000@gamma.student.ljbc>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Beau Kuiper wrote:

> I can imagine how it improves sequenial write performace too. With the
> write cache off, the computer cannot send another write request to the IDE
> device until the last one had finished. By the time the computer is told
> the request was finished and it has sent a new request to the drive, the
> disk would have spun out of the place it was supposed to be placed. The
> drive will then have to wait for the disk to spin around fully again
> before doing the write. With the write cache enabled, several requests can
> be placed into the drive buffer and written in the single revolution of
> the drive.

Might be an explanation. How big are the chunks of data that the
kernel sends to the disk?

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
