Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWB1LLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWB1LLW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWB1LLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:11:22 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:55572 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751520AbWB1LLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:11:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=F11EfMO8cwO4gN6na6IvEOn6z2RhMEkouPrbWf1f9wbLC2N9DA1B0t1ssfONg89w0gvBXQUTQfYxARi15NoWPEuy5B3LbidFGBw3eWL4nxxNioVz3ko0CSSW/mK+AGYA8hCTgtDIB9hTKTeCsPRq043DtGrq+bklzd2tISZqUDI=
Date: Tue, 28 Feb 2006 20:11:15 +0900
From: Tejun Heo <htejun@gmail.com>
To: linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: [ANNOUNCE] quilt2git v0.2
Message-ID: <20060228111115.GA32276@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, v0.2 of quilt2git available.  New in v0.2.

* handles new git HEAD file format properly (regular file storing ref: ...)

* makes use of mail format header from quilt patch description.  From:
  becomes the author, Subject: the subject of the patch.  All commit
  information should be maintained through git2quilt -> quilt2git now.

* --signoff option added.  This option is simply passed to git-commit.

* little fixes

http://home-tj.org/wiki/index.php/Misc
http://home-tj.org/files/misc/quilt2git-0.2
http://home-tj.org/files/misc/git2quilt-0.1

Thanks.

-- 
tejun
