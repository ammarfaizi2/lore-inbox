Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281294AbRKUWHc>; Wed, 21 Nov 2001 17:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKUWHX>; Wed, 21 Nov 2001 17:07:23 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:49426 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281294AbRKUWHS>;
	Wed, 21 Nov 2001 17:07:18 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: marcel@mesa.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: make modules_install fails with latest fileutils 
In-Reply-To: Your message of "Wed, 21 Nov 2001 09:08:54 BST."
             <20011121090854.A15851@joshua.mesa.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Nov 2001 09:06:31 +1100
Message-ID: <7409.1006380391@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001 09:08:54 +0100, 
"Marcel J.E. Mol" <marcel@mesa.nl> wrote:
>On Wed, Nov 21, 2001 at 11:52:26AM +1100, Keith Owens wrote:
>> (2) The correct workaround is
>>      cp -f $(sort $(ALL_MOBJS)) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
>
>shouldn't this then be 'sort -u'.

info make, /$(sort

