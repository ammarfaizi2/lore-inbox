Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262108AbSJNTOF>; Mon, 14 Oct 2002 15:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262109AbSJNTOF>; Mon, 14 Oct 2002 15:14:05 -0400
Received: from dsl-65-188-232-225.telocity.com ([65.188.232.225]:29136 "EHLO
	area51.underboost.net") by vger.kernel.org with ESMTP
	id <S262108AbSJNTOE>; Mon, 14 Oct 2002 15:14:04 -0400
Date: Sun, 13 Oct 2002 15:17:07 -0400 (AST)
From: Ron Henry <dijital1@underboost.net>
To: linux-kernel@vger.kernel.org
Subject: THIS_MODULE->name=""; 
In-Reply-To: <5.1.0.14.2.20021014115238.084140f8@mail1.qualcomm.com>
Message-ID: <Pine.LNX.4.44.0210131510500.4549-100000@area51.underboost.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should there be a check in sys_module_init to check for a 0 lenth name
being specified in struct module? If THIS_MODULE->name=""; is added
within a kernel module, future attempts to load, unload and query a module
will fail. I can't think of any reason why someone should need to ability
to set a 0 length name.

-Ron

"the illiterate of the future are not those who can neither read or write
but those that cannot learn, unlearn and relearn"

