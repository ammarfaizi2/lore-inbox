Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291989AbSBTQsz>; Wed, 20 Feb 2002 11:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292000AbSBTQsq>; Wed, 20 Feb 2002 11:48:46 -0500
Received: from cheetah.monarch.net ([24.244.0.4]:2060 "HELO
	cheetah.monarch.net") by vger.kernel.org with SMTP
	id <S291994AbSBTQsn>; Wed, 20 Feb 2002 11:48:43 -0500
Date: Wed, 20 Feb 2002 09:46:49 -0700
From: "Peter J. Braam" <braam@clusterfs.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: phil@off.net
Subject: tmpfs, NFS, file handles
Message-ID: <20020220094649.X25738@lustre.cfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

At present one can probably not run NFS (or InterMezzo) on top of
tmpfs.

Is there a suggested solution for fh_to_dentry and dentry_to_fh for
tmpfs?  

An "iget" based solution might work but at present tmpfs inodes are
not hashed.

Thanks for any suggestions!

