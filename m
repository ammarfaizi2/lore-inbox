Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTJKS5G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 14:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTJKS5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 14:57:06 -0400
Received: from gagarin.cse.Buffalo.EDU ([128.205.36.11]:63695 "EHLO
	gagarin.cse.buffalo.edu") by vger.kernel.org with ESMTP
	id S263361AbTJKS5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 14:57:05 -0400
Date: Sat, 11 Oct 2003 14:57:04 -0400
From: Chad A Daelhousen <cd9@cse.Buffalo.EDU>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs root fs broken: 2.4.22, 2.5.68+
Message-ID: <20031011185704.GA15776@gagarin.cse.Buffalo.EDU>
References: <20031011143449.GA13029@gagarin.cse.Buffalo.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011143449.GA13029@gagarin.cse.Buffalo.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At Sat, Oct 11, 2003 at 10:34:49AM -0400, Chad A Daelhousen wrote:
> Mounting and remounting reiserfs partition at anywhere other than the
> root works flawlessly.

This is because the usrquota option, present only when mounting / from
fstab, was causing the problem. It was in dmesg all along. Silly me.

-- 
Chad Daelhousen
My opinions are my own, until UB purchases my soul.

