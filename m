Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUHBQ3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUHBQ3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 12:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUHBQ3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 12:29:01 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:64208 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266595AbUHBQ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 12:28:49 -0400
Date: Mon, 2 Aug 2004 18:28:45 +0200
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.6.8-rc2-mm2 with usb and input problems
Message-ID: <20040802162845.GA24725@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi list!

I tried 2.6.8-rc2-mm2 and I still don't get it to work properly for me.
The last kernel which really worked was 2.6.7-mm5. I experience the
following problems:

- USB deadlocking
  USB is still deadlocky, quite often process hang in D+ state.
  Is there something similar to usb-deadlock.fix which I could
  apply to 2.6.7-mm6, but which stumbles over 2.6.8-rc2-mm2?

- psmouse/synaptics
  If I have usb as module, I cannot get synaptics to be recognized.
  Dmitry recommended making psaux driver as modules, but I cannot
  get it as module, because INPUT is automatically set to y, etc
  How is it possible to have USB modular and still get synaptics
  recognized? (or is a modular USB not necessary for S2R now that
  we have CONFIG_USB_SUSPEND?)

To recount the last question:
Is it still necessary for S2R to have USB modular, or is the usb
subsystem slowly ready for use without getting unloaded?


Thanks a lot for the great work and all the best

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
DEEPING ST NICHOLAS (n.)
			--- Douglas Adams, The Meaning of Liff
What street-wise kids do at Christmas. They hide on the rooftops
waiting for Santa Claus so that if he arrives and goes down the
chimney, they can rip stuff off from his sleigh.
