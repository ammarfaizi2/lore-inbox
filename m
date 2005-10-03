Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVJCQMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVJCQMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVJCQMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:12:44 -0400
Received: from nevyn.them.org ([66.93.172.17]:2777 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932342AbVJCQMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:12:44 -0400
Date: Mon, 3 Oct 2005 12:12:42 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Message-ID: <20051003161242.GA24889@nevyn.them.org>
Mail-Followup-To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>,
	linux-kernel@vger.kernel.org
References: <21FFE0795C0F654FAD783094A9AE1DFC0874921D@cof110avexu4.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC0874921D@cof110avexu4.global.avaya.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 09:21:00AM -0600, Davda, Bhavesh P (Bhavesh) wrote:
> Yeah, we could go with PTRACE_SET_IGNORE_SIGNAL (signum), but we'll
> still need a sigset_t like structure in struct task_struct {}.

Right - but a non-exported structure can't present any ABI problems :-)

-- 
Daniel Jacobowitz
CodeSourcery, LLC
