Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbTGOSOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269226AbTGOSOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:14:47 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:64158 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S269190AbTGOSOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:14:46 -0400
Date: Tue, 15 Jul 2003 19:29:31 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Michael Kristensen <michael@wtf.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Unable to boot linux-2.6-test1
Message-ID: <20030715182931.GA18716@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Michael Kristensen <michael@wtf.dk>, linux-kernel@vger.kernel.org
References: <20030715180346.GB3843@sokrates>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715180346.GB3843@sokrates>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 08:03:46PM +0200, Michael Kristensen wrote:
 > #
 > # Input device support
 > #
 > CONFIG_INPUT=m

Because this is m, Kconfig is hiding CONFIG_VT from you.

		Dave

