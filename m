Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbWJKQt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbWJKQt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWJKQt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:49:57 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:10649 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1161138AbWJKQt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:49:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S066qlF4o4zx8bZNqs5sOXtub8Ww+ekFnHPy+46mInAh3GRQ3bsygwgCio+57nUGYPLBV2RiRKoItHfyfxvWqO5RljMqlU6jWdphyqZCSv0UqinXFdETvMTyg7jctEDgh/OvcE3yjAdeNBmoyYtzvr+dnNrKTeamX9NlVw9WOBI=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Thu, 12 Oct 2006 00:48:19 +0800
User-Agent: KMail/1.8.2
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, len.brown@intel.com,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061010212341.GA31972@srcf.ucam.org> <200610102320.13952.dtor@insightbb.com>
In-Reply-To: <200610102320.13952.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610120048.19953.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It would have to be DMI-based to some extent - not all Sonys use the
> > same keys for the same purpose. Misery ensues.
>
> Then we need to add keymap table to the sonypi's input device so that
> keymap can be changed from userspace.
If some key is physically broken, I agree configurable keymap is the only 
solution. But, I don't see any other benefit of doing so, if we expect 
platform specific driver report meaningful key code to input layer.

Thanks,
Luming
