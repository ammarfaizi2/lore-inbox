Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266163AbSKFWUX>; Wed, 6 Nov 2002 17:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266164AbSKFWUX>; Wed, 6 Nov 2002 17:20:23 -0500
Received: from bozo.vmware.com ([65.113.40.131]:22791 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S266163AbSKFWUW>; Wed, 6 Nov 2002 17:20:22 -0500
Date: Wed, 6 Nov 2002 17:26:13 -0800
From: Christopher Li <chrisl@vmware.com>
To: "'Jeremy Fitzhardinge '" <jeremy@goop.org>,
       "'Ext2 devel '" <ext2-devel@lists.sourceforge.net>,
       "'Linux Kernel List '" <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] bug in ext3 htree rename: doesn't delete old nam e, leaves ino with bad nlink
Message-ID: <20021106172613.C7475@vmware.com>
References: <3C77B405ABE6D611A93A00065B3FFBBA080B3D@PA-EXCH2> <20021106094425.GP588@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021106094425.GP588@clusterfs.com>; from adilger@clusterfs.com on Wed, Nov 06, 2002 at 02:44:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 02:44:25AM -0700, Andreas Dilger wrote:

> I am not aware of anything stored in a dentry which would be affected
> by the directory or changes therein at all.  The file name is allocated
> as part of the dentry, and also only holds an inode pointer.

Thanks for the explain. Then there is no problem then.

Chris



