Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTFYOyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 10:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTFYOyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 10:54:24 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:56069 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264499AbTFYOyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 10:54:23 -0400
Date: Wed, 25 Jun 2003 16:08:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625160830.A19958@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org
References: <20030625150629.GA1045@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030625150629.GA1045@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Jun 25, 2003 at 05:06:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 05:06:29PM +0200, Sam Ravnborg wrote:
> hch: Please correct me if I got it wrong with respect to include files.

I don't think it makes sense to have includes outside the current directory
if it's never used from somewhere else.  Otherwise I'd move it to
include/linux/ (for one or two headers) or include/<subsystem>/

