Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVBISPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVBISPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVBISPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:15:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:53752 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261880AbVBISP1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:15:27 -0500
Subject: Re: IRQ threading and non-generics
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050209074331.GA6565@elte.hu>
References: <1107887964.7171.55.camel@dhcp153.mvista.com>
	 <20050209074331.GA6565@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1107972923.10177.39.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 09 Feb 2005 10:15:24 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 23:43, Ingo Molnar wrote:
> eventually ARM should be merged to the generic IRQ subsystem and in the
> process it is very likely that the generic IRQ subsystem has to be
> changed to fit ARM's needs as well. But separating out new features and
> keeping the old ARM blob in place isnt the way this should be done - it
> will only prolong the pain.

	I agree that ARM should eventually merge with the generics, but this
shouldn't be a requirement for RT .. I've already shown that it isn't
needed for RT . 

	I don't want to create different IRQ threading code for each non
generic architecture .. It's possible to use common code without forcing
maintainers into a difficult situation.

Daniel

	

