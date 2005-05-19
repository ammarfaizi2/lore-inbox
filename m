Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVESD1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVESD1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 23:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVESD1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 23:27:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:21730 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262458AbVESD1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 23:27:39 -0400
Date: Wed, 18 May 2005 20:32:41 -0700
From: Greg KH <greg@kroah.com>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matt_domsch@dell.com, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Message-ID: <20050519033241.GA23727@kroah.com>
References: <20050518181342.GA13997@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050518181342.GA13997@littleblue.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 01:13:42PM -0500, Abhay Salunke wrote:
> This is a resubmit of the patch after incorporating all the inputs
> from revieweres. This also has a fix where the packets were leaked in
> the function create_packet line#227.

You did not address the issues I had with your use of binary sysfs files
for all file types.  Please fix that up.

Also, what's wrong with using the existing firmware interface in the
kernel?

thanks,

greg k-h
