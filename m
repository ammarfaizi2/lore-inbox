Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTIOV2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTIOV2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:28:05 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:18185 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261603AbTIOV2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:28:02 -0400
Date: Mon, 15 Sep 2003 23:28:00 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: xsdg <xsdg@freenode.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1, -test4 control key "stuck"
Message-ID: <20030915232800.A1166@pclin040.win.tue.nl>
References: <20030915000411.6d35386d.xsdg@freenode.org> <20030915110028.B957@pclin040.win.tue.nl> <20030915205546.GA12833@perl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030915205546.GA12833@perl>; from xsdg@freenode.org on Mon, Sep 15, 2003 at 08:55:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 08:55:46PM +0000, xsdg wrote:

> What would happen if the kernel received two keypress events, and then one key-
> release event for a single key?  I'd imagine that it'd disregard the duplicate
> keypress

The answers differ for 2.4 and 2.6. For 2.4 each keypress is a keypress,
and key releases are rather unimportant as long as the key is not a
modifier key. For 2.6 we have synthetic repeat, so a second keypress from
the keyboard is ignored, the key repeats with kernel-defined frequency,
and the repeat is ended by the key release.

> any idea what might cause the key sticking problem?

If a key release is not seen, 2.4 doesnt mind, but 2.6 keeps repeating.

> Also, I'm not sure how the final issue I described

Do not recall all items of all letters I answer - sorry.

Andries

