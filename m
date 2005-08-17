Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVHQCFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVHQCFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 22:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVHQCFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 22:05:25 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:13444 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750794AbVHQCFY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 22:05:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HUVWSxSKfRqWX2M9k/dFtesTvmGzQjBP3C6+Q8Yi+0sK1kxSFysr2qj00PfZg6iJ/5l1N9RdDm0Bw7KeXyYforClg/CtqNy1fIC1tO4l9auC8oGf/CHs+lgE4CteqfcDbJ6CIXDzEhJdF14NpQCVTECcjoYDpwOJ0NK9QJl+ykA=
Message-ID: <4f52331f050816190542249721@mail.gmail.com>
Date: Tue, 16 Aug 2005 19:05:21 -0700
From: Fong Vang <sudoyang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4 and 2.6 kernel module
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.4 kernel, modules contain the "kernel_version" identification
in the module itself.  This is an example from the 2.4.18 reiserfs
kernel module:

kernel_version=2.4.18-27.7.xbigmem
using_checksums=1
description=ReiserFS journaled filesystem
author=Hans Reiser <reiser@namesys.com>
license=GPL
kernel_version=2.4.18-27.7.xbigmem
using_checksums=1


This ID doesn't seem to exist anymore in the 2.6 kernel.  How does a
2.6 kernel know if a module is compatible?

Thanks for any help.
