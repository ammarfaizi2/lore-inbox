Return-Path: <linux-kernel-owner+w=401wt.eu-S964905AbXASHij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbXASHij (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 02:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbXASHij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 02:38:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34000 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964905AbXASHii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 02:38:38 -0500
Subject: Re: [ANNOUNCE] System Inactivity Monitor v1.0
From: Arjan van de Ven <arjan@infradead.org>
To: Alessandro Di Marco <dmr@gmx.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <877ivkrv5s.fsf@gmx.it>
References: <877ivkrv5s.fsf@gmx.it>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Fri, 19 Jan 2007 08:38:26 +0100
Message-Id: <1169192306.3055.379.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 20:29 +0100, Alessandro Di Marco wrote:
> Hi all,
> 
> this is a new 2.6.20 module implementing a user inactivity trigger. Basically
> it acts as an event sniffer, issuing an ACPI event when no user activity is
> detected for more than a certain amount of time. This event can be successively
> grabbed and managed by an user-level daemon such as acpid, blanking the screen,
> dimming the lcd-panel light à la mac, etc...


Hi,

why did you chose an ACPI event? I'd expect a uevent (which dbus
captures etc) to be a more logical choice..

Greetings,
   Arjan van de Ven

