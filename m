Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUAUMcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUAUMcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 07:32:53 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:59008 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265939AbUAUMct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 07:32:49 -0500
Date: Wed, 21 Jan 2004 13:32:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: mouse configuration in 2.6.1
Message-ID: <20040121123253.GA538@ucw.cz>
References: <p73r7xwglgn.fsf@verdi.suse.de> <20040121043608.6E4BB2C0CB@lists.samba.org> <20040121132337.7f8d3c79.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040121132337.7f8d3c79.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 21, 2004 at 01:23:37PM +0100, Andi Kleen wrote:

> (brought to you by the department of redundancy department)
> 
> The "new" and "improved" version is apparently:
> 
> psmouse_base.psmouse_proto=bare

2.6.2 will have it as:

psmouse.proto=bare

which isn't that bad.

> And 2.6.0 -> 2.6.1 silently changing to that without any documentation
> anywhere, silently breaking my mouse. And debugging it requires a lot
> of reboots because we have regressed to Windows state where every
> mouse setting change requires a reboot :-/
> 
> Sorry Rusty. You are probably the wrong target for the flame, but a
> combination of probably well intended changes including module_parm
> brought a total usability disaster here.

Keep prepared for yet another silent change (documentation _is_ getting
updated, though). And I'll don my asbestos overall ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
