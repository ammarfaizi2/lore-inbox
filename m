Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVCYW7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVCYW7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVCYW7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:59:33 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:65009 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261871AbVCYW6l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:58:41 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.12-rc1 breaks dosemu
Date: Fri, 25 Mar 2005 23:54:51 +0100
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       linux-msdos@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20050320021141.GA4449@stusta.de> <200503251952.33558.arnd@arndb.de> <1111778074.6312.87.camel@laptopd505.fenrus.org>
In-Reply-To: <1111778074.6312.87.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503252354.53154.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 25 März 2005 20:14, Arjan van de Ven wrote:

> the randomisation patches came in a series of 8 patches (where several
> were general infrastructure); could you try to disable the individual
> randomisations one at a time to see which one causes this effect?

It's caused by top-of-stack-randomization.patch.

 Arnd <><
