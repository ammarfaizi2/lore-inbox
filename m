Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263285AbRFHN7z>; Fri, 8 Jun 2001 09:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbRFHN7p>; Fri, 8 Jun 2001 09:59:45 -0400
Received: from zeus.kernel.org ([209.10.41.242]:44241 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263285AbRFHN7a>;
	Fri, 8 Jun 2001 09:59:30 -0400
Date: Thu, 7 Jun 2001 16:26:25 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 aic7xxx drivers unloads with open sg handles
Message-ID: <20010607162625.A17709@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I am seeing the aic7xxx driver unload itself on 2.4.4 with sg 
loaded and with a user space app holding active handles.  Subsequent
closing and reopening of the /dev/sg0, etc. handles is not 
causing a modprobe autoload of the driver, as normally happens
after the code gets into this state.

Please advise.

Jeff
