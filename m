Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSIETV5>; Thu, 5 Sep 2002 15:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSIETV4>; Thu, 5 Sep 2002 15:21:56 -0400
Received: from zeus.kernel.org ([204.152.189.113]:43161 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S318079AbSIETVz>;
	Thu, 5 Sep 2002 15:21:55 -0400
Date: Thu, 5 Sep 2002 12:11:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Important per-cpu fix.
Message-ID: <20020905191135.GH888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org
References: <20020905144023.A14040@in.ibm.com> <20020905090959.GG888@holomorphy.com> <20020906003853.A16786@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020906003853.A16786@in.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 02:09:59AM -0700, William Lee Irwin III wrote:
>> Are you running on NUMA-Q? Do you also see the tty deadlock?

On Fri, Sep 06, 2002 at 12:38:53AM +0530, Dipankar Sarma wrote:
> No, a 4CPU PIII box. What tty deadlock ?
> Thanks

The one reported in the "mysterious tty deadlock" thread.
Basically, some kind of badness happens where it has to be sent
a signal-generating character before generating output a good
chunk of the time, where extra carriage returns sometimes help.


Cheers,
Bill
