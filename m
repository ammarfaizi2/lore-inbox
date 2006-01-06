Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752208AbWAFDlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbWAFDlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 22:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbWAFDlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 22:41:03 -0500
Received: from quark.didntduck.org ([69.55.226.66]:24533 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1752208AbWAFDlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 22:41:02 -0500
Message-ID: <43BDE71D.3000103@didntduck.org>
Date: Thu, 05 Jan 2006 22:42:21 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
CC: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: .gitignore files really necessary?
References: <20060106022531.GA7152@localhost.localdomain>
In-Reply-To: <20060106022531.GA7152@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> Hello,
> 
> I see you keep updating .gitignore files. That would be a never ending
> extra burden IMHO.  May I suggest we all use KBUILD_OUTPUT instead to keep
> the source tree clean?  Or am I missing you?
> 
> 	Coywolf

Seperate output dirs are nice for building release kernels, but for
doing development it makes things more difficult.  The .gitignore files
don't affect the actual build, so it doesn't matter much if they arent't
totally kept up to date.

--
				Brian Gerst
