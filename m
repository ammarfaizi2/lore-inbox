Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314889AbSENBSB>; Mon, 13 May 2002 21:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314929AbSENBSA>; Mon, 13 May 2002 21:18:00 -0400
Received: from holomorphy.com ([66.224.33.161]:20378 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314889AbSENBSA>;
	Mon, 13 May 2002 21:18:00 -0400
Date: Mon, 13 May 2002 18:16:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>,
        Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: OOPS 2.4.19-pre7-ac4 (Was: strange things in kernel 2.4.19-pre7-ac4 + preempt patch)
Message-ID: <20020514011628.GB27957@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Steve Kieu <haiquy@yahoo.com>,
	kernel <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0205131830080.353-100000@netfinity.realnet.co.sz> <20020514010422.58937.qmail@web10402.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 11:04:22AM +1000, Steve Kieu wrote:
> It doesn't work, I attached the oop log here...

It's trying to unlock a page that isn't locked. Now the question
remains: "Why is it receiving an already-unlocked page?"


Cheers,
Bill
