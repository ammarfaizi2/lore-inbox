Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263501AbRFNSA1>; Thu, 14 Jun 2001 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263574AbRFNSAS>; Thu, 14 Jun 2001 14:00:18 -0400
Received: from zeus.kernel.org ([209.10.41.242]:34017 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S263501AbRFNR77>;
	Thu, 14 Jun 2001 13:59:59 -0400
Date: Thu, 14 Jun 2001 11:33:24 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx problems on 2.4.4
Message-ID: <20010614113324.A30842@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.4.4, with the aic7xxx driver loaded, if a test unit ready 
command (0) is sent to a device which is not loaded via the 
generic scsi interface, it results in the driver rolling out 
of memory, even though sg may have open file handles for 
/dev/sgX, etc. active. 

Jeff

