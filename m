Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTEUM1I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 08:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbTEUM1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 08:27:08 -0400
Received: from sklave3.rackland.de ([213.133.101.23]:33227 "EHLO
	sklave3.rackland.de") by vger.kernel.org with ESMTP id S262100AbTEUM1H
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 21 May 2003 08:27:07 -0400
From: Hadmut Danisch <hadmut@danisch.de>
Date: Wed, 21 May 2003 14:38:43 +0200
To: Dumitru Stama <dics@ecommerce.com>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: speechless 2.5.69 kernel?
Message-ID: <20030521123843.GB7884@danisch.de>
References: <20030521103713.GA5863@danisch.de> <125174092051.20030521140819@ecommerce.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125174092051.20030521140819@ecommerce.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 02:08:19PM +0200, Dumitru Stama wrote:

> I think you have wrong settings of the console.
> Try the standard 80/25 text mode...
> 


Thanks for the hint, that brought me to the problem:

# CONFIG_VGA_CONSOLE is not set


Setting this to y solved the problem.


Thanks and regards
Hadmut



