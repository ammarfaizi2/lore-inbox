Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbTDAQa2>; Tue, 1 Apr 2003 11:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262688AbTDAQa1>; Tue, 1 Apr 2003 11:30:27 -0500
Received: from holomorphy.com ([66.224.33.161]:27266 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262687AbTDAQa1>;
	Tue, 1 Apr 2003 11:30:27 -0500
Date: Tue, 1 Apr 2003 08:41:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030401164126.GA993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org
References: <20030401125159.GA8005@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401125159.GA8005@wind.cocodriloo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 02:51:59PM +0200, Antonio Vargas wrote:
+
+	if(fairsched){
+		/* special processing for per-user fair scheduler */
+	}

I suspect something more needs to happen there. =)

I'd recommend a different approach, i.e. stratifying the queue into a
user top level and a task bottom level. The state is relatively well
encapsulated so it shouldn't be that far out.


-- wli
