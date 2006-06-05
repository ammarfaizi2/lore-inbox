Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751265AbWFESSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWFESSN (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWFESSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:18:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37082 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751271AbWFESSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:18:13 -0400
Date: Mon, 5 Jun 2006 14:18:01 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>, 76306.1226@compuserve.com,
        linux-kernel@vger.kernel.org, jbeulich@novell.com,
        Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060605181801.GB30336@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Laurent Riffard <laurent.riffard@free.fr>,
	76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
	jbeulich@novell.com, Ingo Molnar <mingo@elte.hu>,
	Arjan van de Ven <arjan@linux.intel.com>
References: <200606042101_MC3-1-C19B-1CF4@compuserve.com> <20060604181002.57ca89df.akpm@osdl.org> <44840838.7030802@free.fr> <4484584D.4070108@free.fr> <20060605110046.2a7db23f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605110046.2a7db23f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 11:00:46AM -0700, Andrew Morton wrote:

 > Ingo, what does "vol_id/2233" mean?

process name/pid ?

 > I guess we should force 8k stacks if the lockdep features are enabled.
 > 
 > But x86_64 has no such option.  Problem.

x86-64 always uses 8K stacks. (The increased sizeof(long) makes 4K
really scary.

		Dave

-- 
http://www.codemonkey.org.uk
