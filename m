Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWJEOV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWJEOV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWJEOV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:21:59 -0400
Received: from lixom.net ([66.141.50.11]:11650 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751339AbWJEOV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:21:58 -0400
Date: Thu, 5 Oct 2006 09:21:15 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Enable DEEPNAP power savings mode on 970MP
Message-ID: <20061005092115.6948663f@localhost.localdomain>
In-Reply-To: <1160026464.22232.16.camel@localhost.localdomain>
References: <20061004234141.749b13fb@localhost.localdomain>
	<1160026464.22232.16.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 15:34:24 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Isn't deep nap supposed to only get entered from F/4 which we never
> use ?
> 
> Ben confused...

Nope.

The User Manual clearly talks about going in/out of deep nap from the
different powertune frequencies, see for example section 6.4.2 and 9.4.2.


-Olof
