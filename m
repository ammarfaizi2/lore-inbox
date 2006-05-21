Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWEUKYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWEUKYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 06:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWEUKYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 06:24:11 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:7548 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751506AbWEUKYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 06:24:09 -0400
Date: Sun, 21 May 2006 03:24:07 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Haar J?nos <djani22@netcenter.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure.
Message-ID: <20060521102407.GA5582@taniwha.stupidest.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <20060521081621.GA1151@taniwha.stupidest.org> <010801c67cb1$bc13fd00$1800a8c0@dcccs> <20060521084728.GA2535@taniwha.stupidest.org> <012201c67cb5$7a213800$1800a8c0@dcccs> <20060521091022.GA3468@taniwha.stupidest.org> <014601c67cb9$4f235f30$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014601c67cb9$4f235f30$1800a8c0@dcccs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 11:31:12AM +0200, Haar J?nos wrote:

> 1. why don't use highmem for caching?
> 2. why can not allocate enough lowmem from shared-buffer for the e1000
> driver if it needs some memory?

highmem can't be used as freely as lowmem, it has additional
complexity and a slight over head that makes it hard or impossible to
use in many places
