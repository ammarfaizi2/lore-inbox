Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWE3Uxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWE3Uxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWE3Uxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:53:30 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:32997 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932418AbWE3Ux3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:53:29 -0400
Date: Tue, 30 May 2006 17:53:27 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060530175327.7e3dc824@doriath.conectiva>
In-Reply-To: <20060530113327.297aceb7.zaitcev@redhat.com>
References: <20060529120102.1bc28bf2@doriath.conectiva>
	<20060529132553.08b225ba@doriath.conectiva>
	<20060529141110.6d149e21@doriath.conectiva>
	<20060529194334.GA32440@fks.be>
	<20060529172410.63dffa72@doriath.conectiva>
	<20060529204724.GA22250@fks.be>
	<20060529193330.3c51f3ba@home.brethil>
	<20060530082141.GA26517@fks.be>
	<20060530113801.22c71afe@doriath.conectiva>
	<20060530115329.30184aa0@doriath.conectiva>
	<20060530174821.GA15969@fks.be>
	<20060530113327.297aceb7.zaitcev@redhat.com>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 11:33:27 -0700
Pete Zaitcev <zaitcev@redhat.com> wrote:

| > @@ -967,3 +971,6 @@ MODULE_PARM_DESC(vendor, "User specified
| >  
| >  module_param(product, ushort, 0);
| >  MODULE_PARM_DESC(product, "User specified USB idProduct");
| > +
| > +module_param(connect_retries, int, KP_RETRIES);
| > +MODULE_PARM_DESC(product, "Maximum number of connect retries (100ms each)");
| 
| Personally, I'm not keen on adding knobs.

 We have a device-dependent parameter here, I can't think in anything
better..

-- 
Luiz Fernando N. Capitulino
