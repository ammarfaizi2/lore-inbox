Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264836AbUFPVNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264836AbUFPVNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbUFPVKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:10:55 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:59401 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266303AbUFPVHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:07:11 -0400
Date: Wed, 16 Jun 2004 23:07:08 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christoph Hellwig <hch@infradead.org>, Dirk Jagdmann <doj@cubic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE Auto-Geometry Resizing support missing in 2.6.7?
Message-ID: <20040616210708.GA3951@pclin040.win.tue.nl>
References: <40D0AA07.7010806@cubic.org> <20040616202023.GA19123@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616202023.GA19123@infradead.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : mailhost.tue.nl 1182; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 09:20:23PM +0100, Christoph Hellwig wrote:

> You need to boot with hdX=stroke now.  I had a patch first that allowed both
> run- an compiletime selection but Bart wanted the option to be removed.

Bart is right. Compilation options should select inclusion of subsystems,
modules, drivers, but not twiddle behaviour.

I wondered whether the opposite default would have been better, but
probably the current version is best.

On the other hand, there are too many gratuitous changes in a stable series.
We should soon open 2.7, so that user-visible minor improvements have a place to go.
