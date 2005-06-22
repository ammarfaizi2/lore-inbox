Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVFVSJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVFVSJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFVSIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:08:42 -0400
Received: from peabody.ximian.com ([130.57.169.10]:31660 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261764AbVFVSGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:06:30 -0400
Subject: Re: about prefetch function used by list.h
From: Robert Love <rml@novell.com>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4ae3c1405062210393445b60@mail.gmail.com>
References: <4ae3c1405062210393445b60@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 14:06:29 -0400
Message-Id: <1119463589.3949.327.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-22 at 13:39 -0400, Xin Zhao wrote:

> I use the link management functions  defined in list.h to setup my
> links in user programs. but when I tried to migrate those programs to
> Solaris on Sun workstations, I don't know how to define the function
> prefetch, which is arch dependent.

Just don't use the prefetch stuff.  Rip it out or define it to nothing.

	Robert Love


