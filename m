Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTHSWOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbTHSWOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:14:04 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:17681
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261548AbTHSWOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:14:03 -0400
Date: Tue, 19 Aug 2003 15:13:58 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jeff Garzik <jgarzik@pobox.com>, Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild: Separate ouput directory support
Message-ID: <20030819221358.GE4083@matchmail.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030819214144.GA30978@mars.ravnborg.org> <3F429C5D.4010201@pobox.com> <20030819215656.GE1791@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819215656.GE1791@mars.ravnborg.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 11:56:56PM +0200, Sam Ravnborg wrote:
> On Tue, Aug 19, 2003 at 05:53:33PM -0400, Jeff Garzik wrote:
> > Is it possible, with your patches, to build from a kernel tree on a 
> > read-only medium?
> 
> Yes, thats possible. But I have seen that as a secondary possibility.
> But I know people has asked about the possibility to build a kernel
> from src located on a CD. And thats possible with this patch.

That also means you can run multiple builds over nfs or even on the same
machine from the same tree (or a different tree, that was cp -al and then
patched).

Thanks.

