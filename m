Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUBDQED (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 11:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUBDQED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 11:04:03 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:50327 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262228AbUBDQEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 11:04:01 -0500
Subject: Re: 2.6 probe.c "pcibus_class" Device Class, release function
From: John Rose <johnrose@austin.ibm.com>
To: colpatch@us.ibm.com
Cc: greg KH <gregkh@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <40204B7E.6030408@us.ibm.com>
References: <1075847619.28337.31.camel@verve>  <40204B7E.6030408@us.ibm.com>
Content-Type: text/plain
Message-Id: <1075910444.3026.0.camel@verve>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 10:00:44 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  put() does need to be 
> called twice because the bridge device is get()'d twice: once when the 
> device is registered and once when it's bus device grabs a reference to it.

Looks great, thanks Matt.

John

