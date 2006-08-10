Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161742AbWHJNNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161742AbWHJNNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161749AbWHJNNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:13:05 -0400
Received: from outbound4.mail.tds.net ([216.170.230.94]:14213 "EHLO
	outbound4.mail.tds.net") by vger.kernel.org with ESMTP
	id S1161742AbWHJNNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:13:04 -0400
Subject: RE: Upgrading kernel across multiple machines
From: David Lloyd <dmlloyd@flurg.com>
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA001167638@chicken.machinevisionproducts.com>
References: <14CFC56C96D8554AA0B8969DB825FEA001167638@chicken.machinevisionproducts.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 08:13:57 -0500
Message-Id: <1155215638.24896.3.camel@ultros>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 17:18 -0700, Brian D. McGrew wrote:
> I tried copying over the initrd as well as making a new one!

Ok.  The only reason I mention it is that in many cases, necessary boot
modules are stored in /lib on the initrd image.  Failure to load such a
module would show up early in the boot sequence, before "real" init
started up.

- DML

