Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161383AbWASUI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161383AbWASUI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWASUI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:08:58 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:19469 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161383AbWASUI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:08:57 -0500
Date: Thu, 19 Jan 2006 21:08:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem building in separate directory
Message-ID: <20060119200832.GF3557@mars.ravnborg.org>
References: <43CF82EE.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CF82EE.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 12:15:42PM +0100, Jan Beulich wrote:
> Sam,
> 
> beyond the problem reported in http://marc.theaimsgroup.com/?l=linux-kernel&m=113751198318080&w=2, I see another
> problem: There now is a .kernelrelease file getting generated in the source tree, making it impossible to build from a
> read-only one. Thus I don't think the patch suggested there is correct. Instead, arrangements must be made for the make
> to happen in the output tree instead. I didn't have time to come up with a patch for this, yet.
> 

Hi Jan.

Both issues are now fixed, see patches I just sent out.

	Sam
