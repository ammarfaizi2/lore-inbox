Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275212AbTHRWLU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275213AbTHRWLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:11:19 -0400
Received: from holomorphy.com ([66.224.33.161]:16873 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S275212AbTHRWLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:11:19 -0400
Date: Mon, 18 Aug 2003 15:12:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hank Leininger <hlein@progressive-comp.com>, linux-kernel@vger.kernel.org
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
Message-ID: <20030818221231.GX32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hank Leininger <hlein@progressive-comp.com>,
	linux-kernel@vger.kernel.org
References: <200308182050.h7IKonga016378@marc2.theaimsgroup.com> <20030818210238.GG10320@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818210238.GG10320@matchmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 04:50:49PM -0400, Hank Leininger wrote:
>> ..So not *all* such cases are cause for alarm.  However, if you run one of
>> the patches enabling logging of this, you quickly learn what's normal for
>> the apps you run, and can teach your log-auditing tools and/or your brain
>> to ignore them.

On Mon, Aug 18, 2003 at 02:02:38PM -0700, Mike Fedyk wrote:
> And why not just catch the ones sent from the kernel?  That's the one that
> is killing the program because it crashed, and that's the one the origional
> poster wants logged...

They're almost all sent by the kernel. Very few represent kill(1).


-- wli
