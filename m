Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTKYFSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 00:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTKYFSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 00:18:15 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57103
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261988AbTKYFSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 00:18:13 -0500
Date: Mon, 24 Nov 2003 21:18:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kamal Kumar <kamal.k@sonata-software.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: deleting the content of the file
Message-ID: <20031125051810.GB1331@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Kamal Kumar <kamal.k@sonata-software.com>,
	linux-kernel@vger.kernel.org
References: <33A3630DF4936D44BDDC234FBDD218236B0FD3@mail.sonata-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33A3630DF4936D44BDDC234FBDD218236B0FD3@mail.sonata-software.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 10:41:05AM +0530, Kamal Kumar wrote:
> Hi All,
> I want to delete the content of file through command promp.I do not want to
> open the file.The size is more than 250MB.
> If anybody could suggest me ,how to do it!

Truncating it should do the trick.

echo -n > file
