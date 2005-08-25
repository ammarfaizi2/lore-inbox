Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVHYILe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVHYILe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 04:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVHYILe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 04:11:34 -0400
Received: from ns.firmix.at ([62.141.48.66]:23755 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964869AbVHYILd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 04:11:33 -0400
Subject: Re: time
From: Bernd Petrovitsch <bernd@firmix.at>
To: raja <vnagaraju@effigent.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <430D47F7.9040104@effigent.net>
References: <430D47F7.9040104@effigent.net>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 25 Aug 2005 10:11:22 +0200
Message-Id: <1124957482.10628.2.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 09:54 +0530, raja wrote:
[...]
>      Is There Any function in c  to caliculate the exact time taken to 
> execute block of code(in micro sec and milli  sec and minuits and hours).
> thanking you,

Do you mean system-time, user-space-time or the time it took in the real
world?
And apart from the fact that this is a C programming question and not
directly related to the Linux kernel since it is a user-space thingy,
you probably want to use times(2) two times and calculate the
difference.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

