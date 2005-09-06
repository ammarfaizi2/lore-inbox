Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVIFLai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVIFLai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVIFLah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:30:37 -0400
Received: from ns.firmix.at ([62.141.48.66]:20958 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964812AbVIFLah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:30:37 -0400
Subject: Re: kbuild & C++
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Budde, Marco" <budde@telos.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de>
References: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 06 Sep 2005 13:30:34 +0200
Message-Id: <1126006234.31664.13.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 13:23 +0200, Budde, Marco wrote:
[....]
> for one of our customers I have to port a Windows driver to
> Linux. Large parts of the driver's backend code consists of
> C++. 
> 
> How can I compile this code with kbuild? The C++ support
> (I have tested with 2.6.11) of kbuild seems to be incomplete /
> not working.

Yes, because the official Linux kernel is pure C (using some gcc
extensions).
There is http://netlab.ru.is/exception/LinuxCXX.shtml but it is
a) not integrated (and will probably never) and
b) you can't use parts of C++ anyway with it.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

