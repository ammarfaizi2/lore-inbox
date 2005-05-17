Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVEQRK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVEQRK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVEQRKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:10:17 -0400
Received: from dvhart.com ([64.146.134.43]:13474 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261858AbVEQRJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:09:52 -0400
Date: Tue, 17 May 2005 10:09:47 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4-mm2 build failure
Message-ID: <828790000.1116349787@flay>
In-Reply-To: <826450000.1116349699@flay>
References: <734820000.1116277209@flay> <Pine.LNX.4.62.0505161602460.20110@graphe.net> <826450000.1116349699@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, May 17, 2005 10:08:19 -0700 "Martin J. Bligh" <mbligh@mbligh.org> wrote:

> 
> 
>> There was a prior discussion with the ppc64 folks about the way that 
>> asm-generic/topology.h was included only for CONFIG_NUMA. I thought that 
>> was fixed?
>> 
>> asm-generic/topology.h must also be included if CONFIG_NUMA is not set 
>> inorder to provide the fall back pcibus_to_node function.
> 
> Nope. same failure.

Oops. I lie. Now it gets the other failure (the panic on boot we were
discussing before). So yes, that patch worked.

M.

