Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUDAE5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 23:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbUDAE5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 23:57:20 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:48426 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262259AbUDAE5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 23:57:18 -0500
Date: Thu, 1 Apr 2004 06:58:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Jackson <iggy@gentoo.org>
Cc: linux-kernel@vger.kernel.org, kai@germaschewski.name, sam@ravnborg.org
Subject: Re: [PATCH] Makefile patch to create KBUILD_OUPUT if it doesn't exist
Message-ID: <20040401045857.GA2241@mars.ravnborg.org>
Mail-Followup-To: Brian Jackson <iggy@gentoo.org>,
	linux-kernel@vger.kernel.org, kai@germaschewski.name,
	sam@ravnborg.org
References: <200403311647.37184.iggy@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403311647.37184.iggy@gentoo.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 04:47:35PM -0600, Brian Jackson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> It was probably intentional to not have the Makefile automagically create 
> KBUILD_OUPUT if it doesn't exist, but just in case, here's a patch which 
> makes it do just that.

It was not done so typing errors do not start creating a lot of directories.
but it is also tiresome to type:
mkdir ~/b
make O=~/b ...

Could you make kbuild print out the created directory in kbuild format:
CRDIR   dir/which/is/created

	Sam

