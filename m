Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTDOSZ5 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbTDOSZy 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:25:54 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:21679 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S262906AbTDOSZL (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 14:25:11 -0400
Date: Tue, 15 Apr 2003 14:33:53 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304151436_MC3-1-3487-2164@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:


> In practice, I would
> expect that any "stacking" of multiple security modules that use
> security fields and xattr will actually involve creation of a new module
> that integrates the logic of the individual modules.  This is preferable
> anyway to ensure that the interactions among the security modules are
> well understood, that the logic is combined in a sensible manner, and
> that the individual logics can not subvert one another.


  On FreeBSD 5 you 'stack' the mac_biba and mac_mls modules to get both
integrity and confidentiality, right?  Or is that something different?

--
 Chuck
