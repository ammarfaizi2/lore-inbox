Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbULRTx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbULRTx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 14:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbULRTx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 14:53:29 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:22437 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261222AbULRTx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 14:53:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Y0aKpIW2JqU7vHYtvJ9e7vLvYVOqaxCNEqobSB5dZDKI7VseEoJ1Vf0pLMZZQqSIgLc28K1toWS4sXwFb1FpsyUVrMdhWY+rYz5sAn0M4RycltMFUzUc4gI69hWmP1iHGQ5Mzvf3hVPVdQxT+BBaWzhuEaJA8s26ynwdZ91vH84=
Message-ID: <cce9e37e041218115321c300b9@mail.gmail.com>
Date: Sat, 18 Dec 2004 19:53:25 +0000
From: Phil Lougher <phil.lougher@gmail.com>
Reply-To: Phil Lougher <phil.lougher@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
       "Bhattiprolu, Ravikumar (Ravikumar)" <ravikb@agere.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Magic Number for New File system
In-Reply-To: <20041218023929.GB19699@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <6E1F4DB94568BB4AA8A30083E67378924BB67C@iiex2ku01.agere.com>
	 <20041218023929.GB19699@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004 21:39:29 -0500, Theodore Ts'o <tytso@mit.edu> wrote:
> There's no standard place to put a magic number, let alone a standard
> way to generate a magic number.... 
> 
> The blkid library, contained in the e2fsprogs distribution, contains a
> list of magic number and their locations used by various different
> filesystems, if you'd like to take a look at that for some more
> information.

The disktype program (http://disktype.sourceforge.net)  can be used to
decode the content type of a disk/filesystem image.  It recognises a
large amount of filesystems and partition types etc.  From a quick
glance, the documentation describes the concepts behind magic numbers
and superblock formats, and gives an overview of the filesystem
formats recognised.  If you're new to this, this is probably a
reasonable place to start.

Phillip
