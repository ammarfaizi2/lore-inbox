Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311577AbSC2S4b>; Fri, 29 Mar 2002 13:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311600AbSC2S4V>; Fri, 29 Mar 2002 13:56:21 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10489
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311577AbSC2S4F>; Fri, 29 Mar 2002 13:56:05 -0500
Date: Fri, 29 Mar 2002 10:57:51 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
Message-ID: <20020329185751.GI8627@matchmail.com>
Mail-Followup-To: Anton Altaparmakov <aia21@cus.cam.ac.uk>,
	Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <3CA45BEC.8030106@antefacto.com> <Pine.SOL.3.96.1020329124320.18653A-100000@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 12:57:07PM +0000, Anton Altaparmakov wrote:
> On Fri, 29 Mar 2002, Padraig Brady wrote:
> > Is this a good default?
> 
> I don't see what's wrong with that. It follows the logic of least
> surprise. In Windows all files are executable as there is no way to
> distinguish executables from non-executables due to lack of executable
> bit. NTFS on Linux has no way of telling the difference either and hence
> it makes sense to allow execution of all files.

The difference with NTFS is that there is a possibility to have unix permissions
working with it natively, with no extra visible files like with umsdos.

What are you going to do when unix permissions/ACLs are supported in Linux
NTFS?  Default back to non executable?

How much extra work would it be to map the unix executable bits to a NTFS acl?
