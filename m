Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUCJKek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 05:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUCJKek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 05:34:40 -0500
Received: from gate.firmix.at ([80.109.18.208]:36495 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S262566AbUCJKei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 05:34:38 -0500
Subject: Re: (0 == foo), rather than (foo == 0)
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1078914873.23072.3.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 11:34:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reformatted long lines - please fix your mailer.

On Mit, 2004-03-10 at 07:16, Godbole, Amarendra (GE Consumer &
Industrial) wrote:
> While writing code, the assignment operator (=) is many-a-times confused
> with the comparison operator (==) resulting in very subtle bugs difficult
> to track. To keep a check on this -- the constant can be written on the 
> LHS rather than the RHS which will result in a compile time error if wrong
> operator is used.

Or you use `gcc -Wall` which also reports this (and also in the cases
where both sides of the comparison can be left hand sides).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

