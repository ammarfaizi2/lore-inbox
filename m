Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbUA0PpI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbUA0PpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:45:08 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:13251 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S263002AbUA0PpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:45:05 -0500
Date: Tue, 27 Jan 2004 15:44:56 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: RFC: Trailing blanks in source files
Message-ID: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	It seems that many files [1] in the Linux source have lines with
trailing blank (space and tab) characters and some even have formfeed
characters. Obviously these blank characters aren't necessary.

	I wonder if it is a waste of time to send patches that clean the
source? Those patches will only remove those trailing blank characters and
will be splitted by maintainer.


Regards,
	Rui Saraiva


[1]
> grep -lR "[[:blank:]]$" /usr/src/linux/ | wc -l
   8163

