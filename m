Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUFPVKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUFPVKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 17:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbUFPVKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 17:10:39 -0400
Received: from [213.146.154.40] ([213.146.154.40]:64415 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264791AbUFPVIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 17:08:24 -0400
Date: Wed, 16 Jun 2004 22:08:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Dirk Jagdmann <doj@cubic.org>, linux-kernel@vger.kernel.org
Subject: Re: IDE Auto-Geometry Resizing support missing in 2.6.7?
Message-ID: <20040616210823.GA20015@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries Brouwer <aebr@win.tue.nl>, Dirk Jagdmann <doj@cubic.org>,
	linux-kernel@vger.kernel.org
References: <40D0AA07.7010806@cubic.org> <20040616202023.GA19123@infradead.org> <20040616210708.GA3951@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616210708.GA3951@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 11:07:08PM +0200, Andries Brouwer wrote:
> On Wed, Jun 16, 2004 at 09:20:23PM +0100, Christoph Hellwig wrote:
> 
> > You need to boot with hdX=stroke now.  I had a patch first that allowed both
> > run- an compiletime selection but Bart wanted the option to be removed.
> 
> Bart is right. Compilation options should select inclusion of subsystems,
> modules, drivers, but not twiddle behaviour.

Oh, as I wrote in my initial submission I totally agree.  I just think removing the
option in 2.7 is better than in the middle of a stable series.

