Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRBMMRu>; Tue, 13 Feb 2001 07:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129417AbRBMMRk>; Tue, 13 Feb 2001 07:17:40 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:45445 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129197AbRBMMRd>; Tue, 13 Feb 2001 07:17:33 -0500
From: Christoph Rohland <cr@sap.com>
To: Admin Mailing Lists <mlist@intergrafix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shared memory problem
In-Reply-To: <Pine.LNX.4.10.10102121304250.24584-100000@athena.intergrafix.net>
Organisation: SAP LinuxLab
In-Reply-To: <Pine.LNX.4.10.10102121304250.24584-100000@athena.intergrafix.net>
Message-ID: <m3k86vm1lg.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 13 Feb 2001 13:23:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Admin,

On Mon, 12 Feb 2001, Admin Mailing Lists wrote:
> 
> I've been using the 2.2.x series successfully, latest i used was
> 2.2.19pre7.  Today i upgraded to 2.4.1-ac9 and noticed that shared
> memory shows 0.  I searched the list archive briefly and someone
> said the stats have been broken since sometime in 2.3, 

Yes, right.

> but my system also shows my swap being used up a great deal (100MB
> whereas i'm rarely using more than 5MB (and that only at loaded
> times, which this isn't))

Yes, that's normal for 2.4. As soon as you run into swap it will eat
more swap space and keep it also if the load is smaller. This makes
overall swapping faster.

> this server is dedicated for apache web serving, and CONFIG_TMPFS is
> not configured in/any shm fs mounted. I didn't have this in 2.2
> either.

Doesn't have anything to do with tmpfs/shm fs.

Greetings
		Christoph


