Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965342AbWCTPjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965342AbWCTPjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbWCTPjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:39:04 -0500
Received: from kanga.kvack.org ([66.96.29.28]:31449 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965001AbWCTPia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:38:30 -0500
Date: Mon, 20 Mar 2006 10:32:57 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]micro optimization of kcalloc
Message-ID: <20060320153257.GF16108@kvack.org>
References: <Pine.LNX.4.58.0603201542250.17461@fachschaft.cup.uni-muenchen.de> <20060320151433.GE16108@kvack.org> <200603201633.29532.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603201633.29532.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 04:33:29PM +0100, Oliver Neukum wrote:
> The likely case is passing constants. Without inlining precisely the
> likely case cannot be optimised.

That's what __builtin_constant_p() is for.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
