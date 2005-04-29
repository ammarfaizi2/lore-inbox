Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVD2BtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVD2BtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 21:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVD2BtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 21:49:13 -0400
Received: from mail.aei.ca ([206.123.6.14]:28666 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262370AbVD2BtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 21:49:10 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: new mm pending, git/cogito question.
Date: Thu, 28 Apr 2005 21:50:52 -0400
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504282150.52245.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andrew stated a new mm version is pending.  This brings up a question.  With bk I would do

bk clone -ql -rv2.6.12-rc3 local-linux-2.6 2.6-rc3
cd 2.6-rc3
bk import -tpatch ../andrews-rc3-mmx-patch .
bk -r get -q

Given that I have a current git db of the kernel and up to date cogito tools, what do I do to
get a directory in the same state as above?

TIA,
Ed Tomlinson
