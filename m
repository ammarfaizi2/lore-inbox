Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTKKFa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 00:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTKKFa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 00:30:29 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:7913 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264259AbTKKFa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 00:30:28 -0500
Date: Mon, 10 Nov 2003 21:30:14 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Joseph Shamash <info@avistor.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Peter Chubb <peter@chubb.wattle.id.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
Message-ID: <20031110213014.A2274@beaverton.ibm.com>
References: <16304.23206.924374.529136@wombat.chubb.wattle.id.au> <HBEHKOEIIJKNLNAMLGAOOEDFDKAA.info@avistor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <HBEHKOEIIJKNLNAMLGAOOEDFDKAA.info@avistor.com>; from info@avistor.com on Mon, Nov 10, 2003 at 08:03:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 08:03:53PM -0800, Joseph Shamash wrote:

> The limitation we have found in 2.6 is lack FC HBA drivers which 
> are needed to support large storage capacities.
> 
> Any thoughts?

Please clarify "lack FC HBA drivers".

You mean no in kernel drivers? Yeh.

The qlogic (qla2xxx) driver is not in the kernel, but is available for use
with 2.6.

Martin Bligh included an emulex driver in his last 2.6 patch set.

-- Patrick Mansfield
