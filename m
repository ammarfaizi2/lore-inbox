Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTFFNCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 09:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTFFNCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 09:02:36 -0400
Received: from holomorphy.com ([66.224.33.161]:39359 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261322AbTFFNCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 09:02:35 -0400
Date: Fri, 6 Jun 2003 06:12:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arvind Kandhare <arvind.kan@wipro.com>
Cc: "indou.takao" <indou.takao@jp.fujitsu.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC][PATCH 2.5.70] Static tunable semvmx and semaem
Message-ID: <20030606131238.GE8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arvind Kandhare <arvind.kan@wipro.com>,
	"indou.takao" <indou.takao@jp.fujitsu.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Dave Jones <davej@suse.de>,
	Manfred Spraul <manfred@colorfullife.com>
References: <3EE02C53.1040800@wipro.com> <20030606065023.GB8978@holomorphy.com> <3EE0586F.9060108@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE0586F.9060108@wipro.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 02:31:35PM +0530, Arvind Kandhare wrote:
> As we have discussed earlier, making it dynamic can cause some race 
> conditions in the system
> (Please refer thread "Changing SEMVMX to a tunable parameter" on 28 May 
> 2003).

I'm sorry about the confusion. I forgot the earlier thread. Please
disregard my earlier comments wrt. dynamism, as they appear to be in
conflict with other notions.

I think the __setup()'s should be moved to ipc/sem.c; otherwise I think
manfred's the right person to do the review here and I'll back off.


-- wli
